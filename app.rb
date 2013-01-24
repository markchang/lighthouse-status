require 'sinatra'
require 'taskmapper'
require 'taskmapper-lighthouse'

get '/' do
  lighthouse = TaskMapper.new(:lighthouse, {:token => "6c479cc509fba68adcc74d0b69e84dde10078a66",:account => "edx"})
  studio = lighthouse.projects[0]

  # get all tickets that have tags
  tickets = studio.tickets.select
  tagged_tickets = tickets.select {|t| not t.tag.nil?}
  untagged_tickets = tickets.select {|t| t.tag.nil?}
  open_cat_1 = tagged_tickets.select {|t| t.tag.include? "cat-1" and  (t.state == "open" or t.state == "reviewed")}
  open_cat_2 = tagged_tickets.select {|t| t.tag.include? "cat-2" and  (t.state == "open" or t.state == "reviewed")}
  open_cat_3 = tagged_tickets.select {|t| t.tag.include? "cat-3" and  (t.state == "open" or t.state == "reviewed")}
  open_features = tagged_tickets.select {|t| t.tag.include? "feature" and  (t.state == "open" or t.state == "reviewed")}
  new_tickets = tickets.select {|t| t.state == "new"}

  "Open CAT-1 tickets %d" % new_tickets.count
end
