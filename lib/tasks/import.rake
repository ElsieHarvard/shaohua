desc "Import Data, command line:\n $ rake import[type, path]"
task :import, [:type, :path] => :environment do |t, args|

  # Load Article from path
  load_arc_ary = lambda {
    files = Dir["./workpath/#{ args.path }/*"]
    import = lambda { |filepath|
      obj = Hash.new
      File.open( filepath , 'r:utf-8') do |file|
        # Read raw content from file
        raw = file.read
        ta = filepath.split('/')[-1].split('.')[0].split('_')
        if ta.size == 2
          obj[:arc_title], obj[:arc_author] = ta
        else
          (tm, raw = raw.split("\n",2) rescue raise filepath)
          obj[:arc_title], obj[:arc_author], obj[:arc_ext] = tm.split('/')[-1].split('.')[0].split('_')
          obj[:arc_number] = ta[0].to_i
        end
        obj[:arc_content] = raw
      end
      return obj
    }
    objs = files.collect do |pth|
      obj = import.call pth
      if $DEBUG
        printf "> Import from \"#{ pth }\":\n"
        printf "Details:\n"
        printf "  file_size: #{ obj[:arc_content].size } bytes\n"
        printf "Meta Data: \n"
        printf "  arc_title: #{ obj[:arc_title] }\n"
        printf "  arc_author: #{ obj[:arc_author] }\n"
        printf "  arc_content: #{ obj[:arc_content][0...32] }\n"
        printf "  arc_number: #{ obj[:arc_number] }"
        printf "\n"
      end
      next obj
    end
    printf "Load #{objs.size} articles.\n"
    return objs
  }

  # Format Article
  format_article = lambda { |arc|
    rst = Article.new
    rst.arc_title = arc[:arc_title] || '无题'
    ( arc[:arc_author] || '佚名' ).split('&').each{ |author|
      rst.add_author author
    }
    rst.arc_content = arc[:arc_content] || (raise 'Empty Article: ' + arc.inspect)
    if arc[:arc_ext] == 'locked'
      printf("\e[31mLocked Article:" + arc[:arc_title] + "\e[0m\n")
    else
      Aricle.find_b(idhsh:rst.chkidhsh).nil? ? rst.save : \
        printf("\e[31mAlready Exist:" + rst.chkidhsh + "\e[0m\n")
    end
  }

  case args.type
  when 'articles'
    printf "Import Article form \"./workpath/#{ args.path }/*\".\n"
    obj = nil
    begin
      arc_ary = load_arc_ary.call
      arc_ary.each { |arc| format_article.call arc }
    rescue RuntimeError => e
      p e
      printf "The Source file must be formatted and coded with utf-8.\n"
    end
  else
    printf "Unknown File Type, Sorry!\n"
    printf "These types are registered:\n"
    printf "articles\n"
    printf "You arguments are:\n"
    p args
  end
  printf "Done!\n"
end
