FROM public.ecr.aws/lambda/nodejs:16

WORKDIR /app

COPY . .

CMD [ "app.lambdaHandler" ]
