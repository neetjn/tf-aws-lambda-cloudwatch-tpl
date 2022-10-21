# tf-aws-lambda-cloudwatch-tpl
The goal of this project is to learn how to leverage Terraform with aws to stage basic infrastructure for a lambda function with cloudwatch logging and monitoring.

## Development

The lambda proposed in this project has relatively no function but logging provided event information.
It's written with LiveScript and transpiled using Parcel.
Terraform is using two providers:

* `archive` @ `hashicorp/archive` - Used to bundle lambda and hash source code for detecting changes.
* `aws` @ `hashicorp/aws` - AWS module for setting up infrastructure.

To build the lambda use `make build`. Assuming you have an active AWS session, use `make plan` and `make deploy` to plan and apply the given TF infrastructure.

## Goals

* [x] Create iam role for lambda.
* [x] Create logging policy for lambda with CloudWatch.
* [x] Create lambda.
* [x] Create sns topic for alarms.
* [x] Create CloudWatch alarms.
* [ ] Break down TF into modules.

---

Copyright (c) 2022 John Nolette Licensed under the MIT License.
