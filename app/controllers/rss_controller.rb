require 'open-uri'
require 'digest/md5'
require 'rexml/document'
class RssController < ApplicationController
   def list
       @feeds = Feed.all
   end
   def new
       @feed = Feed.new
   end
   def create
      @feed = Feed.new(feed_params)
      doc = REXML::Document.new(open(@feed.link))
      doc.elements.each("rss/channel/title") do |node|
          @feed.title=node.text
      end
      @feed.save
      redirect_to :action => 'list'
   end
   def delete
       Feed.find(params[:id]).destroy
       redirect_to :action => 'list'
   end
   def feed_params
      params.require(:rss).permit(:link,:group_id)
   end
   
   def getnews
       doc = REXML::Document.new(open(Feed.find(params[:id]).link))
       group=Feed.find(params[:id]).group_id
       doc.elements.each("rss/channel/item/title") do |node|
                    newArticle=News.new do |f|
                        f.feed_id=params[:id]
                        f.title=node.text
                        f.sumcheck=Digest::MD5.hexdigest(group.to_s+f.title)
                    end
                    if News.where(:sumcheck => newArticle.sumcheck).empty?
                     newArticle.save  
                    end
                end
       redirect_to :action => 'listnews'
   end
   def updateall
        Feed.all.ids.each do |i|
           doc = REXML::Document.new(open(Feed.find(i).link))
           group=Feed.find(i).group_id
                doc.elements.each("rss/channel/item/title") do |node|
                    newArticle=News.new do |f|
                        f.feed_id=i
                        f.title=node.text
                        f.sumcheck=Digest::MD5.hexdigest(group.to_s+f.title)
                    end
                    if News.where(:sumcheck => newArticle.sumcheck).empty?
                     newArticle.save  
                    end
                end
       end
       redirect_to :action => 'listnews'
   end
   
   def listnews
       @news = News.all
   end
end
