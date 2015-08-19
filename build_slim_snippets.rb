require 'html2slim'

Dir["**/*.sublime-snippet"].each do |s|
  next if s["-slim"] #snip slim snippets
  dest = s.gsub(".sublime-snippet","-slim.sublime-snippet")
  doc = Hpricot::XML File.read(s)
  slim = HTML2Slim::HTMLConverter.new((doc/:content).text).to_s
  File.open(dest,"w") do |f|
    f.puts <<-XML
<snippet>
  <content><![CDATA[
#{slim}
]]></content>
  <tabTrigger>#{(doc/:tabTrigger).text}</tabTrigger> 
  <scope>source.slim</scope>
</snippet>
    XML
  end
end