"""
This script checks lists of RSS feeds against keywords thought to highlight cyclist/pedestrian incidents.
"""

from csv import writer
from datetime import datetime
import feedparser
import os

# whether to archive this run
archive = False

# timestamp for recording purposes
ts = datetime.timestamp(datetime.now())

feed_dir = "rss_feeds"

feeds_to_check = {
    "CBC":"cbc_rss.txt",
    "Radio-Canada":"radio_canada_rss.txt",
    "Global":"global_rss.txt",
    "CTV":"ctvnews_rss.txt",
    "QC":"quebec_fixed_rss.txt",
    "Nitter_fr":"nitter_fr_rss.txt",
    "Nitter_en":"nitter_en_rss.txt"}


# Import keywords as a list
keywords_en = [k for k in open("keywords_en.txt", "r").read().rstrip().split("\n")]
keywords_fr = [k for k in open("keywords_fr.txt", "r").read().rstrip().split("\n")]

# Track all hits in a master file
master_url_file = "data/rss_matches.csv"
master_urls = []

# Search for stories from selected RSS feeds
for k in feeds_to_check.keys():
    print(feeds_to_check[k])
    name = k
    rss_file = feeds_to_check[k]

    print("Beginning RSS keyword check for", name)

    rss_list = [l for l in open(os.path.join(feed_dir, rss_file), "r").read().rstrip().split("\n")]

    for rss in rss_list:
        try:
            feed = feedparser.parse(rss)

            try:
                for entry in feed["entries"]:
                    # print(entry)
                    if any(k in entry["title"].lower() for k in keywords_en or \
                            any(k in entry["link"].lower() for k in keywords_en)):
                        print()
                        print("Keyword match:", entry["title"])
                        print("Link:", entry["link"])
                        print()
                        master_urls.append([entry["title"],entry["link"],name,ts])
            except Exception as e1:
                print("Exception", e1, "in RSS:", rss)
        except Exception as e2:
            print("Exception", e2, "Error with:", rss)

# Save our results if we want to archive them.
if archive:
    with(open(master_url_file,"a",newline="")) as f_obj:
        w_obj = writer(f_obj)

        # Append URLs to file
        for murl in master_urls:
            w_obj.writerow(murl)

        f_obj.close()
else:
    # if we don't want to archive, overwrite a temp file if we want ot manually add it later
    with(open("data/temp_url_file", "w", newline="")) as f_obj:
        w_obj = writer(f_obj)

        # Append URLs to file
        for murl in master_urls:
            w_obj.writerow(murl)

        f_obj.close()