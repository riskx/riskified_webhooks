aws_config = YAML::load(File.open(File.join('config', 'aws.yml')))[ENV["RACK_ENV"] || "development"]
SQS_CONNECTION = RightAws::SqsGen2.new(aws_config['aws_access_key_id'],aws_config['aws_secret_access_key'])

SQS_QUEUE = SQS_CONNECTION.queue(["riskified_webhooks_", ENV["RACK_ENV"] || "development"].join)