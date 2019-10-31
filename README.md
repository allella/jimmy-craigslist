## Disclaimer
[Craigslist's terms of use](https://www.craigslist.org/about/terms.of.use) prohibit scraper, bots, etc.  However, Craiglist provides RSS feeds, therefore expecting and endorsing the use of RSS readers. This code is effectively a personal RSS reader which saves a copy of RSS data and allows real RSS readers (AOL Reader, Feedly, Digg Reader) to consume your personal copies.

Also, CL likely will block popular, cheap hosting services such as Digital Ocean. If you immediately get a message like the following, then the issue is likely a broad blocking of the host's IP range.

``This IP has been automatically blocked.
If you have questions, please email: blocks-b1565046728099160@craigslist.org``

## Why You Would Care

### Craigslist Feeds
Nowadays, Craigslist RSS doesn't work with most popular RSS Readers.

Any service which is widely used results in a high volume of requests going to Craigslist. They don't like the volume and block and blacklist those services' requesting IP addresses.

Search the internet and you'll see where these reader services have asked Craigslist to whitelist
their servers. Craiglist either doesn't care or provides, at best, a temporary fix.

This script allows you to automatically save Craigslist RSS feed data to your own web server and provide an endpoint/URL for your favorite RSS reader to consume.

As long as you're not hammering Craiglist from a single IP address (too many feed requests at once or too frequent), you
should be able to avoid being blacklisted and life is good.

### Google Groups, Google News, and Google RSS Feeds with Feedly

This may also come in handy to self-poll feeds from Google Groups, Google Alerts, and Google News, thus saving a personal copy of each RSS feed and providing a non-traditional domain and URL which you can then provide to readers, like Feedly.

To learn about the available RSS feeds provided by Google Groups just try the following pattern, where "URL-KEY-HERE" is the last part of base the URL for your group.

Example. If you'r group URL is
https://groups.google.com/forum/#!forum/URL-KEY-HERE
then visit
https://groups.google.com/forum/#!aboutgroup/URL-KEY-HERE

## Installation

### Prerequisites

1.  A Linux web server
2.  Shell / command line access (using SFTP/FTP and a control panel would work too but is not included in these docs)

By default we'll install in your Linux Home directory, which is private (not web accessible)
**Avoid installing the script itself in a public directory (i.e. don't save under public_html or www)** 

### Method 1 - Download and Unzip
```
cd ~ && wget https://github.com/allella/jimmy-craigslist/archive/master.zip
unzip master.zip && mv jimmy-craigslist-master jimmy-craigslist
cd ~/jimmy-craigslist && chmod u+x jimmy-c.sh
mkdir -p /home/insert-your-username/public_html/insert-a-public-directory-name/
```
----------------------------------------------------------------------------
### Method 2 - Clone the Repo with Git
```
cd ~ && git clone https://github.com/allella/jimmy-craigslist.git
cd ~/jimmy-craigslist && chmod u+x jimmy-c.sh
mkdir -p /home/insert-your-username/public_html/insert-a-public-directory-name/
```

## How To Define Your Feeds and Aliases

Edit the feeds.csv file.
Add one line for each Craigslist RSS feed URL in the format {alias w/ no spaces}|{feed URL}

Here's an example of two URLs with the aliases 'vise' and 'work-bench'
```
vise|https://yourcityhere.craigslist.org/search/sss?format=rss&amp;query=vise&amp;srchType=A
work-bench|https://yourcityhere.craigslist.org/search/sss?format=rss&amp;query=work%20bench&amp;srchType=A
some-google-group|https://groups.google.com/forum/feed/some-google-group/topics/rss.xml?num=15
```
## How to Manually Run / Test the Script

This must run from the Linux command shell. There are two input parameters:

1.  The public directory where XML files will be saved. This MUST end in a trailing slash (/) and the Linux user MUST be able to write to it. If you followed the install steps you already specified and/or created this directory.
2.  The max pause (in seconds) between downloading each XML file (not to be confused with the cron job's frequency). In this example it will pause up to 20 seconds between saving aliases.

```
sh jimmy-c.sh /home/insert-your-username/public_html/insert-a-public-directory-name/ 20
```

Once the script has successfully run you will have an XML file in your public directory for each line in feeds.csv

## Setting Up An Automated Cron Job / Tab 

The only step left is to create a cron tab / job to schedule your server to fetch and save
the XML however many times a day (just don't hammer the Craiglist server)

From the Linux command line / shell (run the following command)

```
crontab -e
```
(Note, cron is usually edited using vi. If you're not familiar with vi then know that you must press 'i' before you can type/insert. Then add your cron rule and press ESC and  then type :wq and Enter to save Or, to exit without saving hit ESC and then type :q! and hit Enter)

When the cron opens up add a rule like the following.

```
# This will run at 8:50 AM , 12:50 AM, 4:45 PM, and 10:45 PM with a 20 second pause between each URL download
50 8,12,16,20 * * * sh jimmy-c.sh /home/insert-your-username/public_html/insert-a-public-directory-name/ 20
```

### Rules For Setting Your Cron Timing
* Please change these minute and hour values to fit your needs so everyone using this script isn't hitting Craigslist at the same time.
* Keep in mind that if you run this very frequently then you're more likely to get blacklisted
* There's a random delay (up to 20 seconds) between each XML file being saved in order to avoid hammering Craigslist.
* **If you are saving a lot of XML files and/or running the cron job very frequently then you run the risk of starting this script before an earlier instance has finished. You can adjust the cron tab run times and the maxPause to avoid things getting weird**

## Submitting URLs To Your RSS Reader
By now you should now have valid public URLS for each of your aliases.

```
https://www.example.com/insert-a-public-directory-name/alias-name.xml
```

Replace the URLs above with your specific domain, public directory, and alias and you have
the URLs you'd submit to your RSS Reader.
