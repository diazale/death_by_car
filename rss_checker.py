"""
This script checks lists of RSS feeds against keywords thought to highlight cyclist/pedestrian incidents.
"""

import feedparser
import os

feed_dir = "rss_feeds"

# CBC, Radio-Canada
feeds_to_check = ["CBC","Radio-Canada","Global"]
#feeds_to_check = ["CBC","Radio-Canada"]
feeds_to_check = ["CTV"]

# Import keywords as a list
keywords_en = [k for k in open("keywords_en.txt", "r").read().rstrip().split("\n")]
keywords_fr = [k for k in open("keywords_fr.txt", "r").read().rstrip().split("\n")]

##### ENGLISH, CBC #####

if "CBC" in feeds_to_check:
    print()
    print("BEGINNING CBC CHECK")
    print()
    # Get a list of CBC RSS feeds
    cbc_rss = [l for l in open(os.path.join(feed_dir,"cbc_rss.txt"), "r").read().rstrip().split("\n")]

    for rss in cbc_rss:
        try:
            #print("Trying RSS:", rss)
            feed = feedparser.parse(rss)

            try:
                for entry in feed["entries"]:
                    # print(entry)
                    if any(k in entry["title"].lower() for k in keywords_en or \
                            any(k in entry["link"].lower() for k in keywords_en)):
                        print()
                        print("KEY HIT:", entry["title"])
                        print(entry["link"])
                        print()
            except Exception as e1:
                print("Exception", e1, "in RSS:", rss)
        except Exception as e2:
            print("Exception", e2, "Error with:", rss)

##### FRENCH, RADIO-CANADA #####

if "Radio-Canada" in feeds_to_check:
    print()
    print("BEGINNING RADIO-CANADA CHECK")
    print()
    rc_rss = []
    temp = []

    for l in open(os.path.join(feed_dir, "radio_canada_rss.txt"), "r").read().strip().split("\n"):

        if "rss" in l:
            temp.append(l)
        elif len(l) > 0:
            temp.append(l)

        if len(temp)==2:
            rc_rss.append(temp)
            temp = []

    del temp

    # Note that the RSS list here has two elements, so the feedparser part is changed slightly
    for rss in rc_rss:
        try:
            #print("Trying RSS:", rss)
            feed = feedparser.parse(rss[1])

            try:
                for entry in feed["entries"]:
                    # print(entry)
                    if any(k in entry["title"].lower() for k in keywords_fr or \
                            any(k in entry["link"].lower() for k in keywords_fr)):
                        print()
                        print("KEY HIT:", entry["title"])
                        print(entry["link"])
                        print()
            except Exception as e1:
                print("Exception", e1, "in RSS:", rss)
        except Exception as e2:
            print("Exception", e2, "Error with:", rss)

if "Global" in feeds_to_check:
    print()
    print("BEGINNING GLOBAL TV CHECK")
    print()

    global_rss = [l for l in open(os.path.join(feed_dir,"global_rss.txt"), "r").read().rstrip().split("\n")]

    for rss in global_rss:
        try:
            #print("Trying RSS:", rss)
            feed = feedparser.parse(rss)

            try:
                for entry in feed["entries"]:
                    # print(entry)
                    if any(k in entry["title"].lower() for k in keywords_en) or \
                            any(k in entry["link"].lower() for k in keywords_en):
                        print()
                        print("KEY HIT:", entry["title"])
                        print(entry["link"])
                        print()
            except Exception as e1:
                print("Exception", e1, "in RSS:", rss)
        except Exception as e2:
            print("Exception", e2, "Error with:", rss)

if "CTV" in feeds_to_check:
    print()
    print("BEGINNING CTV CHECK")
    print()

    global_rss = [l for l in open(os.path.join(feed_dir,"ctvnews_rss.txt"), "r").read().rstrip().split("\n")]

    for rss in global_rss:
        try:
            print("Trying RSS:", rss)
            feed = feedparser.parse(rss)

            try:
                for entry in feed["entries"]:
                    # print(entry)
                    if any(k in entry["title"].lower() for k in keywords_en) or \
                            any(k in entry["link"].lower() for k in keywords_en):
                        print()
                        print("KEY HIT:", entry["title"])
                        print(entry["link"])
                        print()
            except Exception as e1:
                print("Exception", e1, "in RSS:", rss)
        except Exception as e2:
            print("Exception", e2, "Error with:", rss)