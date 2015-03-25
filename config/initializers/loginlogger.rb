login_logfile = File.open("#{Rails.root}/log/login.log", 'a')
login_logfile.sync = true
LOGIN_LOG = LoginLogger.new(login_logfile)
