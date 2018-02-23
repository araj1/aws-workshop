Steps for the Challenge :

1. Complete the exercise :- HandsOnExercise3Stack.json
aws cloudformation create-stack --stack-name <StackName> --template-url https://s3-us-west-2.amazonaws.com/idc-aws-session/HandsOnExercise3Stack.json --parameters ParameterKey=LoadBalancerName,ParameterValue=<ElbName> ParameterKey=KeyName,ParameterValue=<KeyName> ParameterKey=ImageId,ParameterValue=<imageId>

2. From the given link :- https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#LoadBalancers:sort=loadBalancerName , find the DNS name for the load Balancer. Ex: amit-stack-1876591461.us-west-2.elb.amazonaws.com
3. The format for the URL to be tested for WAF application : DNS-Name/redirect/?domain-name
Ex: amit-stack-842351824.us-west-2.elb.amazonaws.com/redirect/?https://www.hotstar.com
4. The list of domains and user-agents are available in the Data.xls
5. Using the AWS WAF, create a web-ACL to allow calls from the domains and user-agents in Data.xls
6. WAF Details :-
  https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-rules.html
  Use Regex patterns test for maximum possible of domains and user-agents in the list for the redirect-rules
7. WAF Limits on Number of rules :- docs.aws.amazon.com/waf/latest/developerguide/limits.html
