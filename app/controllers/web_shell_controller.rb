class WebShellController < ApplicationController
  before_filter :authenticate_shell_user!, only: [:local_user]
end
