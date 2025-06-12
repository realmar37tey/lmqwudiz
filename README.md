<!--
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
-->

[Chinese](README_CN.md)
## APISIX

[![Build Status](https://travis-ci.org/apache/incubator-apisix.svg?branch=master)](https://travis-ci.org/apache/incubator-apisix)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/apache/incubator-apisix/blob/master/LICENSE)

- **QQ group**: 552030619
- Mail list: Mail to dev-subscribe@apisix.apache.org, follow the reply to subscribe the mail list.
- ![Twitter Follow](https://img.shields.io/twitter/follow/ApacheAPISIX?style=social)

APISIX is a cloud-native microservices API gateway, delivering the ultimate performance, security, open source and scalable platform for all your APIs and microservices.

APISIX is based on Nginx and etcd. Compared with traditional API gateways, APISIX has dynamic routing and plug-in hot loading, which is especially suitable for API management under micro-service system.

## Why APISIX?

If you are building a website, mobile device or IoT (Internet of Things) application, you may need to use an API gateway to handle interface traffic.

APISIX is a cloud-based microservices API gateway that handles traditional north-south traffic and handles east-west traffic between services, and can also be used as a k8s ingress controller.

APISIX provides dynamic load balancing, authentication, rate limiting, other plugins through plugin mechanisms, and supports plugins you develop yourself.

For more detailed information, see the [White Paper](https://www.iresty.com/download/Choosing%20the%20Right%20Microservice%20API%20Gateway%20for%20the%20Enterprise%20User.pdf).

![](doc/images/apisix.png)

## Features
You can use Apache APISIX as a traffic entrance to process all business data, including dynamic routing, dynamic upstream, dynamic certificates,
A/B testing, canary release, blue-green deployment, limit rate, defense against malicious attacks, metrics, monitoring alarms, service observability, service governance, etc.

- **All platforms**
    - Cloud-Native: Platform agnostic, No vendor lock-in, APISIX can run from bare-metal to Kubernetes.
    - Run Environment: Both OpenResty and Tengine are supported.
    - Supports [ARM64](https://zhuanlan.zhihu.com/p/84467919): Don't worry about the lock-in of the infra technology.

- **Multi protocols**
    - [TCP/UDP Proxy](doc/stream-proxy.md): Dynamic TCP/UDP proxy.
    - [Dynamic MQTT Proxy](doc/plugins/mqtt-proxy.md): Supports to load balance MQTT by `client_id`, both support MQTT [3.1.*](http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html), [5.0](https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html).
    - [gRPC proxy](doc/grpc-proxy.md)：Proxying gRPC traffic.
    - [gRPC transcoding](doc/plugins/grpc-transcoding.md)：Supports protocol transcoding so that clients can access your gRPC API by using HTTP/JSON.
    - Proxy Websocket
    - Proxy Dubbo: proxy Dubbo based on Tengine.
    - HTTP(S) Forward Proxy
    - [SSL](doc/https.md): Dynamically load an SSL certificate.

- **Full dynamic**
    - [Hot Updates And Hot Plugins](doc/plugins.md): Continuously updates its configurations and plugins without restarts!
    - [Proxy Rewrite](doc/plugins/proxy-rewrite.md): Support for rewriting the `host`, `uri`, `schema`, `enable_websocket`, `headers` information upstream of the request.
    - [Response Rewrite](doc/plugins/response-rewrite.md): Set customized response status code, body and header to the client.
    - [Serverless](doc/plugins/serverless.md): Invoke functions in each phase in APISIX.
    - Dynamic Load Balancing: Round-robin load balancing with weight.
    - Hash-based Load Balancing: Load balance with consistent hashing sessions.
    - [Health Checks](doc/health-check.md)：Enable health check on the upstream node, and will automatically filter unhealthy nodes during load balancing to ensure system stability.
    - Circuit-Breaker: Intelligent tracking of unhealthy upstream services.

- **Fine-grained routing**
    - [Supports full path matching and prefix matching](doc/router-radixtree.md#how-to-use-libradixtree-in-apisix)
    - [Support all Nginx built-in variables as conditions for routing](/doc/router-radixtree.md#how-to-filter-route-by-nginx-builtin-variable), so you can use `cookie`,` args`, etc. as routing conditions to implement canary release, A/B testing, etc.
    - Support [various operators as judgment conditions for routing](https://github.com/iresty/lua-resty-radixtree#operator-list), for example `{"arg_age", ">", 24}`
    - Support [custom route matching function](https://github.com/iresty/lua-resty-radixtree/blob/master/t/filter-fun.t#L10)
    - IPv6: Use IPv6 to match route.
    - Support [TTL](doc/admin-api-cn.md#route)
    - [Support priority](doc/router-radixtree.md#3-match-priority)

- **Security**
    - Authentications: [key-auth](doc/plugins/key-auth.md), [JWT](doc/plugins/jwt-auth.md)
    - [IP Whitelist/Blacklist](doc/plugins/ip-restriction.md)
    - [IdP](doc/plugins/oauth.md): Support external authentication services, such as Auth0, okta, etc., users can use this to connect to Oauth2.0 and other authentication methods.
    - [Limit-req](doc/plugins/limit-req.md)
    - [Limit-count](doc/plugins/limit-count.md)
    - [Limit-concurrency](doc/plugins/limit-conn.md)
    - Anti-ReDoS(Regular expression Denial of Service): Built-in policies to Anti ReDoS without configuration.

- **OPS friendly**
    - OpenTracing: [support Apache Skywalking and Zipkin](doc/plugins/zipkin.md)
    - Monitoring And Metrics: [Prometheus](doc/plugins/prometheus.md)
    - Clustering: APISIX nodes are stateless, creates clustering of the configuration center, please refer to [etcd Clustering Guide](https://github.com/etcd-io/etcd/blob/master/Documentation/v2/clustering.md).
    - Dashboard: Built-in dashboard to control APISIX.
    - Version Control: Supports rollbacks of operations.
    - CLI: start\stop\reload APISIX through the command line.
    - [Stand-alone mode](doc/stand-alone.md): Supports to load route rules from local yaml file, it is more friendly such as under the kubernetes(k8s).
    - Global Rule: Allows to run any plugin for all request, eg: limit rate, IP filter etc.
    - High performance: The single-core QPS reaches 18k with an average delay of less than 0.2 milliseconds.
    - [REST admin API](doc/admin-api.md)

- **Highly scalable**
    - [Custom plugins]((doc/plugin-develop.md)): Allows hooking of common phases, such as `rewrite`, `access`, `header filer`, `body filter` and `log`, also allows to hook the `balancer` stage.
    - Custom load balancing algorithms: You can use custom load balancing algorithms during the `balancer` phase.
    -Custom routing: Support users to implement routing algorithms themselves.

## Installation

APISIX Installed and tested in the following systems(OpenResty MUST >= 1.15.8.1, or Tengine >= 2.3.2):

CentOS 7, Ubuntu 16.04, Ubuntu 18.04, Debian 9, Debian 10, macOS, **ARM64** Ubuntu 18.04

Steps to install APISIX:
1. Installation runtime dependencies: OpenResty and etcd, refer to [documentation](doc/install-dependencies.md)
2. There are several ways to install Apache APISIX:
    - [Source Release](doc/how-to-build.md#installation-via-source-release)
    - [RPM package](doc/how-to-build.md#installation-via-rpm-package-centos-7) for CentOS 7
    - [Luarocks](doc/how-to-build.md#installation-via-luarocks-macos-not-supported)
    - [Docker](https://github.com/apache/incubator-apisix-docker)

## Quickstart

1. start server:

```shell
sudo apisix start
```

2. try limit count plugin

Limit count plugin is a good start to try APISIX,
you can follow the [documentation of limit count](doc/plugins/limit-count.md).

Then you can try more [plugins](doc/README.md#plugins).

## Dashboard
APISIX has built-in support for dashboards, as follows:

- Download the source code of [dashboard](https://github.com/apache/incubator-apisix-dashboard):
```
git clone https://github.com/apache/incubator-apisix-dashboard.git
```

- Install dependencies and build
```
yarn
yarn run build:prod
```

- Integration with APISIX
Copy the compiled files under `/dist` directory to the `apisix/dashboard` directory,
open `http://127.0.0.1:9080/apisix/dashboard/` in the browser.
Do not need to fill the user name and password, log in directly.

The dashboard allows any remote IP by default, and you can modify `allow_admin` in `conf/config.yaml` by yourself, to list the list of IPs allowed to access.

We provide an online dashboard [demo version](http://apisix.iresty.com), make it easier for you to understand APISIX.

## Benchmark

Using AWS's 8 core server, APISIX's QPS reach to 140,000 with a latency of only 0.2 ms.

## Document
[Documents of Apache APISIX](doc/README.md)

## Apache APISIX vs Kong

#### both of them have been covered core features of API gateway

| **feature**   | **Dynamic upstream**   | **Health check**   | **Dynamic SSL**   | **L4 and L7 proxy**   | **opentracing**   | **custom plugin**   | **REST API**   | **CLI**   |
|:----|:----|:----|:----|:----|:----|:----|:----|:----|
| **Apache APISIX**   | Yes   | Yes   | Yes   | Yes   | Yes   | Yes   | Yes   | Yes   |
| **Kong**   | Yes   | Yes   | Yes   | Yes   | Yes   | Yes   | Yes   | Yes   |

#### The advantages of Apache APISIX
| **Features**   | **Apache APISIX**   | **Kong**   |
|:----|:----|:----|
| belongs to   | Apache Software Foundation   | Kong Inc.   |
| Tech Architecture | Nginx + etcd   | Nginx + postgres   |
| Communication channels  | Mail list, Wechat group, QQ group, Github, meetup   | Github,freenode, forum   |
| Single-core CPU, QPS(enable limit-count and prometheus plugins)   | 18000   | 1700   |
|  latency | 0.2 ms   | 2 ms   |
| IPv6    | Yes   | No   |
| ARM64   | Yes   | No   |
| Dubbo   | Yes   | No   |
| Configuration rollback   | Yes   | No   |
| route with TTL   | Yes   | No   |
| plug-in hot loading   | Yes   | No   |
| custom LB and route   | Yes   | No   |
| resty <--> gRPC transcoding   | Yes   | No   |
| Tengine   | Yes   | No   |
| MQTT    | Yes   | No   |
| Configuration effective time   | Event driven, < 1ms   | polling, 10 seconds   |
| dashboard   | Yes   | No   |
| IdP   | Yes   | No   |
| Configuration Center HA   | Yes   | No   |
| Speed limit for a specified time window   | Yes   | No   |

## Videos And Articles
- 2019.12.14 [From 0 to 1: APISIX's Apache travel(Chinese)](https://zhuanlan.zhihu.com/p/99620158)
- 2019.12.14 [Next-generation microservice architecture based on Apache APISIX(Chinese)](https://www.upyun.com/opentalk/445.html)
- 2019.10.30 [Introduction to Apache APISIX Microservice Gateway Extreme Performance Architecture(Chinese)](https://www.upyun.com/opentalk/440.html)
- 2019.9.27 [Want to run APISIX on an ARM64 platform? Just three steps(Chinese)](https://zhuanlan.zhihu.com/p/84467919)
- 2019.8.31 [APISIX technology selection, testing and continuous integration(Chinese)](https://www.upyun.com/opentalk/433.html)
- 2019.8.31 [APISIX high performance practice 2(Chinese)](https://www.upyun.com/opentalk/437.html)
- 2019.7.6 [APISIX high performance practice(Chinese)](https://www.upyun.com/opentalk/429.html)

## User Stories
- [ke.com: How to Build a Gateway Based on Apache APISIX(Chinese)](https://mp.weixin.qq.com/s/yZl9MWPyF1-gOyCp8plflA)
- [360: Apache APISIX Practice in OPS Platform(Chinese)](https://mp.weixin.qq.com/s/zHF_vlMaPOSoiNvqw60tVw)
- [HelloTalk: Exploring Globalization Based on OpenResty and Apache APISIX(Chinese)](https://www.upyun.com/opentalk/447.html)
- [Tencent Cloud: Why choose Apache APISIX to implement the k8s ingress controller?(Chinese)](https://www.upyun.com/opentalk/448.html)
- [aispeech: Why we create a new k8s ingress controller?(Chinese)](https://mp.weixin.qq.com/s/bmm2ibk2V7-XYneLo9XAPQ)

## Who Uses APISIX?
A wide variety of companies and organizations use APISIX for research, production and commercial product, including:

<img src="https://raw.githubusercontent.com/iresty/iresty.com/master/user-wall.jpg" width="900" height="500">

Users are encouraged to add themselves to the [Powered By](doc/powered-by.md) page.

## Landscape
<p align="left">
<img src="https://landscape.cncf.io/images/left-logo.svg" width="150">&nbsp;&nbsp;<img src="https://landscape.cncf.io/images/right-logo.svg" width="200">
<br/><br/>
APISIX enriches the <a href="https://landscape.cncf.io/category=api-gateway&format=card-mode&grouping=category">
CNCF API Gateway Landscape.</a>
</p>

## Contributing

See [CONTRIBUTING](Contributing.md) for details on submitting patches and the contribution workflow.

## Acknowledgments

inspired by Kong and Orange.
