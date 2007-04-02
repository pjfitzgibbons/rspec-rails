task :pre_commit do
  railses = File.dirname(__FILE__) + '/vendor/rails'
  used_railses = []
  Dir["#{railses}/*"].reverse.each do |rails_dir|
    unless rails_dir =~ /edge/
      rails_version = rails_dir[railses.length+1..-1]
      ENV['RSPEC_RAILS_VERSION'] = rails_version
      used_railses << rails_version
      rake = (PLATFORM == "i386-mswin32") ? "rake.cmd" : "rake"
      cmd = "#{rake} rspec:pre_commit"
      system(cmd)
      raise "'#{cmd}' failed" if $? != 0
    end
  end
  puts "All specs passed against the following versions of Rails: #{used_railses.join(", ")}"
end