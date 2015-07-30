Sharing counter
===============


Installation
----

First start by adding this gem to your Gemfile:

``` ruby
gem 'sharing_counter'
```
And then execute
```
$ bundle
```


Configuring
----

For a Rails app, your config/initializers/sharing_counter.rb file should look like this:
``` ruby
SharingCounter.configure do |config|
 config.vk = { app_id: ENV['VK_API_KEY'] }
 config.facebook = { measurement: ENV['FACEBOOK_MEASUREMENT'] }
end
```
`facebook[:measurement]` can assume any value from `'total_count'`, `'like_count'`, `'comment_count'` and `'total_count'`. The default is `'total_count'`

Usage
-----
``` ruby
> counter = SharingCounter.get_count "http://theoryandpractice.ru"
=> {:url=>"http://theoryandpractice.ru", :data=>2014-04-29 15:29:51 +0400, :facebook=>1984, :twitter=>825, :vk=>0, :ok=>0, :delay=>0.570361}

> counter = SharingCounter.get_count "http://theoryandpractice.ru", [:facebook]
=> {:url=>"http://theoryandpractice.ru", :data=>2014-04-29 15:31:22 +0400, :facebook=>1984, :delay=>0.443431}

> counter = SharingCounter.get_count "http://theoryandpractice.ru", [:twitter]
=> {:url=>"http://theoryandpractice.ru", :data=>2014-04-29 15:37:49 +0400, :twitter=>825, :delay=>0.435011}

> counter = SharingCounter.get_count "http://theoryandpractice.ru", [:vk]
=> {:url=>"http://theoryandpractice.ru", :data=>2014-04-29 15:31:02 +0400, :vk=>0, :delay=>0.061093}

> counter = SharingCounter.get_count "http://theoryandpractice.ru", [:ok]
=> {:url=>"http://theoryandpractice.ru", :data=>2014-04-29 15:31:02 +0400, :ok=>0, :delay=>0.061093}
```
