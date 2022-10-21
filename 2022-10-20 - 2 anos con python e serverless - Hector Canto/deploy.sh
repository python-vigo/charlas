# serverless framework usual comands
serverless deploy --stage production --region eu-central-1
serverless doctor
serverless remove --stage staging --region eu-west-1
# metrics, config, tests, rollback, ...

# live AWS logging
aws logs tail "/aws/lambda/my-lambda-function" --color on --profile debug@prod_account --region eu-central-1 --follow