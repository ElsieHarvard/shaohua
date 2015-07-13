class ForumBoardController < ApplicationController
	def new_board
		@bbs = true
		return unless need_login
	end
	def create_board
		@bbs = true
		return unless need_login
		return unless need_admin
		board = ForumBoard.new(params.require(:board).permit(:board_name)).save
		redirect_to "/bbs"
	end
	def show_board
		if /\A\h{64}\Z/.match params[:hash]
			@bbs = true
			@board = ForumBoard.find_by(board_hash:params[:hash])
			@threads = ForumThread.where(thread_board:@board.board_hash)
		else
			return raise404
		end
	end
end
