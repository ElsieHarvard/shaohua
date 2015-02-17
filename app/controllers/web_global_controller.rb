class WebGlobalController < ApplicationController
  def mainsite_navigator
  end
  def usrlogin
  	render status: 200, plain: params.inspect
  end
end
