require "sinatra"
require "open-uri"

set :raise_errors, false
set :show_exceptions, false

before do
  @about_me = 'http://about.me/zhangjingqiang'
  @twitter = 'http://twitter.com/zhangjingqiang'
  @facebook = 'https://www.facebook.com/zhangjingqiang'
  @google_plus = 'https://plus.google.com/111238723646169905787'
  @github = 'https://github.com/zhangjingqiang'
  @google = 'http://www.google.com'
  @google_search = 'http://www.google.com/search?q='
  @freebsd = 'http://www.freebsd.org'
  @openbsd = 'http://www.openbsd.org'
  @netbsd = 'http://www.netbsd.org'
  @sinatra = 'http://sinatrarb.com'
end

helpers do
    def type(keyword = NULL)
        url = URI.escape("#{@google_search + keyword}")
        doc = Nokogiri::HTML(open(url))
        @content = Hash.new{|h, key| h[key] = []}
        doc.css("h3 a").each do |site|
            @content[:site_href] << site[:href]
            @content[:site_text] << site.text
        end
        doc.css("div[class='s'] span").each do |description|
            @content[:description] << description
        end
        @content
    end
end

get '/' do
    @contentFreeBSD = type("FreeBSD")
    @contentOpenBSD = type("OpenBSD")
    @contentNetBSD = type("NetBSD")

    erb :index
end
