Sidekiq::Cron::Job.create(
  name: 'Hello World Job',
  cron: '*/1 * * * * *', # Run every 5 seconds
  class: 'HelloWorldJob'
)

Sidekiq::Cron::Job.create(
  name: 'Send morning Email Job',
  cron: '* * * * *',
  class: 'SendMorningMailJob'
)
