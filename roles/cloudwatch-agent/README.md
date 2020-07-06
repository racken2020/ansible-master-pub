# Ansible role for installing amazon-cloudwatch-agent
On every ec2 instance you wish to monitor with cloudwatch agent, the instance's IAM role must contain the managed policy ```CloudWatchAgentServerPolicy```. That allows the instance to publish metrics to cloudwatch.

## Tested on
- AmazonLinux 2018 (amzn1)
- AmazonLinux2 (amzn2)
- RHEL7.6

## Doc
* https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/create-iam-roles-for-cloudwatch-agent.html
* https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-on-first-instance.html
* https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Agent-custom-metrics-collectd.html
* https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Agent-procstat-process-metrics.html
