module PeriodicalsHelper
  def getarcsh(hsh)
    # raise hsh
    if /\h{64}/.match hsh
      if PeriodicalArticle.exists?(:archash=>hsh.downcase.chomp)
        return PeriodicalArticle.find_by(archash:hsh.downcase.chomp)
      else
        raise '404'
      end
    elsif /\h{39}/.match hsh
      if Article.exists?(:archash=>hsh.downcase.chomp)
        return Article.arcfind(hsh.downcase.chomp)
      else
        raise '404'
      end
    else
      raise 'BadArcHsh'
    end
  end
end
