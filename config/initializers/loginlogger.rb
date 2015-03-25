login_logfile = File.open("#{Rails.root}/log/login.log", 'a')
login_logfile.sync = true
LOGIN_LOG = Logger.new(login_logfile)
