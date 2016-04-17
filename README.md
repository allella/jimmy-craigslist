## Why You Would Care

Nowadays, Craigslist RSS doesn't work with most RSS Readers because systems like
AOL Reader, Feedly, Digg Reader are widely used and Craigslist blocks / blacklists
those services' requests.

Search the internet and you'll see where these services have asked Craigslist to whitelist
their servers and Craiglist either blows them off or provides a temporary fix.

This script allows you to automatically download copies of Craigslist RSS feeds to your own
web server and then provides those copies as public URLs to your RSS reader to consume.

As long as you're not hammering Craiglist (too many feed requests at once or too frequent), you
should be able to avoid being blacklisted and life is good.

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
mkdir -p /home/insert-your-username/public_html/insert-a-public-directory-name
```
----------------------------------------------------------------------------
###Method 2 - Clone the Repo with Git
```
cd ~ && git clone https://github.com/allella/jimmy-craigslist.git
cd ~/jimmy-craigslist && chmod u+x jimmy-c.sh
mkdir -p /home/insert-your-username/public_html/insert-a-public-directory-name
```

## How To Run It Manually

Edit the feeds.csv file.
Add one line for each Craigslist RSS feed URL in the format {alias w/ no spaces}|{feed URL}

Here's an example of two URLs with the aliases 'vise' and 'work-bench'
```
vise|https://yourcityhere.craigslist.org/search/sss?format=rss&amp;query=vise&amp;srchType=A
work-bench|https://yourcityhere.craigslist.org/search/sss?format=rss&amp;query=work%20bench&amp;srchType=A
```
Each feed URL will be saved to an XML file in a public directory on your web server.
If you followed the install steps you already specificed (and created if it did not exist)
a public directory to hold the XML files.

Now, to execute / test this run the following command from the command line / shell. The Linux user must have
permissions to write to this directory

There are command line input parameters:

1.  The public directory where things will be saved
2.  (ex. 20) The max pause (in seconds) bewteen downloading each XML file (not to be confused with how frequently the cron runs)

```
sh jimmy-c.sh /home/insert-your-username/public_html/insert-a-public-directory-name 20
```

The script should run and, using the example above, you should now have two newly created
XML files in your public directory. 

* https://www.example.com/insert-a-public-directory-name/vise.xml
* https://www.example.com/insert-a-public-directory-name/work-bench.xml

Replace the URLs above with your specific domain and directory and alias and those are
the URLs you'd submit to your RSS Reader.

The only step left is to create a cron tab / job to schedule your server to fetch and save
the XML however many times a day (just don't hammer the Craiglist server)

## Setting Up An Automated Cron Job / Tab 

From the Linux command line / shell (run the following command)

```
crontab -e
```

(Note, the cron is usually edited using vi. If you're not familiar with vi then know that
 you must press 'i' before you can type/insert. Then add your cron rule and press ESC and
 then type :wq and Enter to save Or, to exit without saving hit ESC and then type :q! and hit Enter)

When the cron opens up add a rule like this to run the script at

Please change these values to fit your needs AND so everyone who uses this script
isn't hitting Craigslist at the same time

Keep in mind that if you run this very frequently then you're more likely to get blacklisted

Also keep in mind there's a random delay (up to 20 seconds) between each XML file being saved
in order to avoid hammering Craigslist.

**If you are saving a lot of XML files and/or running the cron job very frequently then
you run the risk of starting this script before an earlier instance has finished
You can adjust the cron tab run times and the maxPause to avoid things getting weird**

```
# This will run at 8:50 AM , 12:50 AM, 4:45 PM, and 10:45 PM with a 20 second pause between each URL download
50 8,12,16,20 * * * sh sh jimmy-c.sh /home/insert-your-username/public_html/insert-a-public-directory-name 20
```
