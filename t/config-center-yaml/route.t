use t::APISix 'no_plan';

repeat_each(1);
log_level('info');
no_root_location();
no_shuffle();

sub read_file($) {
    my $infile = shift;
    open my $in, $infile
        or die "cannot open $infile for reading: $!";
    my $cert = do { local $/; <$in> };
    close $in;
    $cert;
}

our $yaml_config = read_file("conf/config.yaml");
$yaml_config =~ s/node_listen: 9080/node_listen: 1984/;
$yaml_config =~ s/enable_heartbeat: true/enable_heartbeat: false/;
$yaml_config =~ s/config_center: etcd/config_center: yaml/;
$yaml_config =~ s/enable_admin: true/enable_admin: false/;

run_tests();

__DATA__

=== TEST 1: sanity
--- yaml_config eval: $::yaml_config
--- apisix_yaml
routes:
  -
    uri: /hello
    upstream:
        nodes:
            "127.0.0.1:1980": 1
        type: roundrobin
#END
--- request
GET /hello
--- response_body
hello world
--- error_log
use config_center: yaml
--- no_error_log
[error]



=== TEST 2: route:uri + host (missing host, not hit)
--- yaml_config eval: $::yaml_config
--- apisix_yaml
routes:
  -
    id: 1
    uri: /hello
    host: foo.com
    upstream:
        nodes:
            "127.0.0.1:1980": 1
        type: roundrobin
#END
--- request
GET /hello
--- error_code: 404
--- error_log
use config_center: yaml
--- no_error_log
[error]



=== TEST 3: route:uri + host
--- yaml_config eval: $::yaml_config
--- apisix_yaml
routes:
  -
    uri: /hello
    host: foo.com
    upstream:
        nodes:
            "127.0.0.1:1980": 1
        type: roundrobin
#END
--- more_headers
host: foo.com
--- request
GET /hello
--- response_body
hello world
--- no_error_log
[error]
