"""
This script checks lists of RSS feeds against keywords thought to highlight cyclist/pedestrian incidents.
"""

# TODO: move whitelist/blacklist to txt

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
     "Nitter_en":"nitter_en_rss.txt"
}
feeds_to_check_en = {
    "CBC":"cbc_rss.txt",
    "Global":"global_rss.txt",
    "CTV":"ctvnews_rss.txt",
    "Nitter_en":"nitter_en_rss.txt"
}

feeds_to_check_fr = {
    "Radio-Canada":"radio_canada_rss.txt",
    "QC":"quebec_fixed_rss.txt",
    "Nitter_fr":"nitter_fr_rss.txt"
}

# Import keywords as a list
keywords_en = [k for k in open("keywords_en.txt", "r").read().rstrip().split("\n")]
keywords_fr = [k for k in open("keywords_fr.txt", "r").read().rstrip().split("\n")]

# Import URLs I've already recorded
used_urls = [k for k in open("data/sources").read().rstrip().split("\n")][1:] # Skip header
used_urls = [k.replace("\"","").split(",")[1] for k in used_urls] # Convert column to list

# Track all hits in a master file
master_url_file = "data/rss_matches.csv"
master_urls = []

# If this flag is true, search my various lists of RSS feeds
specific_news = True

# Flag to check Google News
google_french = True
google_english = True

# filter for the google search
valid_dates = ['22 Jun','23 Jun','24 Jun','25 Jun']

# Search for stories from selected RSS feeds
if specific_news:
    # French
    for k in feeds_to_check_fr.keys():
        print(feeds_to_check_fr[k])
        name = k
        rss_file = feeds_to_check_fr[k]

        print("Beginning RSS keyword check for", name)

        rss_list = [l for l in open(os.path.join(feed_dir, rss_file), "r").read().rstrip().split("\n")]

        for rss in rss_list:
            try:
                feed = feedparser.parse(rss)
                try:
                    for entry in feed["entries"]:

                        if (any(k in entry["title"].lower() for k in keywords_fr) or \
                            any(k in entry["link"].lower() for k in keywords_fr) or \
                            any(k in entry["description"].lower() for k in keywords_fr)) and \
                            any(m in entry["published"] for m in valid_dates) and \
                            entry["link"] not in used_urls:
                            print()
                            print("Keyword match:", entry["title"])
                            print("Link:", entry["link"])
                            print("Published:", entry["published"])

                            print()
                            master_urls.append([entry["title"],entry["link"],name,ts])
                except Exception as e1:
                    print("Exception", e1, "in RSS:", rss)
            except Exception as e2:
                print("Exception", e2, "Error with:", rss)

    # English
    for k in feeds_to_check_en.keys():
        print(feeds_to_check_en[k])
        name = k
        rss_file = feeds_to_check_en[k]

        print("Beginning RSS keyword check for", name)

        rss_list = [l for l in open(os.path.join(feed_dir, rss_file), "r").read().rstrip().split("\n")]

        for rss in rss_list:
            try:
                feed = feedparser.parse(rss)
                try:
                    for entry in feed["entries"]:
                        if (any(k in entry["title"].lower() for k in keywords_en) or \
                            any(k in entry["link"].lower() for k in keywords_en) or \
                            any(k in entry["description"].lower() for k in keywords_en)) and \
                            any(m in entry["published"] for m in valid_dates) and \
                            entry["link"] not in used_urls:
                            print()
                            print("Keyword match:", entry["title"])
                            print("Link:", entry["link"].split("?cmp=rss")[0])
                            print("Published:", entry["published"])

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


# Custom google RSS search
########## Google French ##########

search_keys = ["pi%C3%A9ton","pieton","cyclist","happe","happ%C3%A9","percut%C3%A9","percute"]
filtered_urls = [".be",".fr",".vn",".ch","ledauphine","nicematin","laprovence","lejsl",".re",".lu",
                 "infonormandie",".mu",".ma","lavenir.net","corsematin",".corsica","ivoire","bienpublic",
                 "tendanceouest","lanauweb","varmatin"] # filter out non-qc news
filtered_words = ["France", ".fr",".re","7sur7","Var-matin","Alsace","Martinique","20 Minutes",
                  "Algerie","Le Télégramme","Le Progrès",".be","La Provence","Paris","Midi Libre",
                  "Calais", "Le Soir","Luxemburger","News 24","RTL","Le Bien Public","Le Defi Media",
                  "Activ Radio","Haute Gironde","Le Dauphin","La Voix du Nord","MaCommune.info",
                  "Le Berry","Nice Matin","Republican","Actu17","InsideNews","Yahoo","Marseille",
                  "Bordeaux","- Sud Ouest","Nice matin","L'Ardennais","Ardennais","DH Les Sports",
                  "La Presse de la Manche","Flandres","aufeminin","Est R","Plein Air","Chasse Passion",
                  "AUNIS TV","L'essentiel","Gerardmer","Lorrain","Gedour","Hebdo","La Nouvelle","Le Matin",
                  "Corse-Matin","lavenir.net", "Yahoo Canada"]

filtered_urls = filtered_urls + used_urls

rss = "https://news.google.ca/rss/search?q=" + "|".join(search_keys) + "&hl=fr-CA&gl=CA&ceid=CA:fr&when:7d"

if google_french:
    print("BEGINNING GOOGLE NEWS FRENCH")
    try:
        print(rss)
        feed = feedparser.parse(rss)

        print(feed)

        try:
            for entry in feed["entries"]:
                if (any(m in entry["published"] for m in valid_dates) and not entry["link"] in used_urls) and \
                        not any(bl in entry["link"].lower() for bl in filtered_urls) and \
                        not any(bl in entry["title"] for bl in filtered_words):
                    print()
                    print(entry["title"])
                    print(entry["link"].split("?cmp=rss")[0])
                    print(entry["published"])

        except Exception as e1:
            print("Exception", e1, "in RSS:", rss)
    except Exception as e2:
        print("Exception", e2, "Error with:", rss)

########## Google English ##########
search_keys = ["(pedestrian&struck)","pedestrian","(cyclist&struck)","cyclist","struck","bicycle"]
filtered_urls = ["bbc.com","espn.com","washington",".co.uk","stv.tv",".gy","ksl.com","mlive.com", \
                 "wgntv.com",".au","wreg.com","tmj4","indianexpress","abc","nbc","al.com",".ie",".co.nz",
                 "pedestrian.tv",".in"] # filter out non-ca news
filtered_words = ["Boston.com","FOX","KTLA","KPRC","New York","Times of India","AL.com","Los Angeles",
                  "Houston","NBC","ABC","Belfast","Michigan","Washington Post","sunchronicle",
                  "The Republic","1News","CBS","MassLive","Route Fifty","BBC","Chicago","Reno",
                  "Pasadena","WJHG","Spectrum News 1","San Francisco","Davis Enterprise","KAIT",
                  "West Palm","York Daily Record","WHP Harrisburg","The News Leader","New Orleans",
                  "Suffolk Times","Deltaplex News","Modesto","KFVS","Arizona","Hudson","KSBY",
                  "Amarillo","WSMV","PennLive","Western Mass","Koam","USA TODAY","MLive.com",
                  "Cincinnati","Cumbria Crack", "Surrey Live","Patriot Ledger","bbc.com",".ie",
                  "Yahoo Canada Sports"]
#filtered_urls = filtered_urls + used_urls

rss = "https://news.google.ca/rss/search?q=" + "|".join(search_keys) + "&hl=en-CA&gl=CA&ceid=CA:en"

if google_english:
    print("BEGINNING GOOGLE NEWS ENGLISH")
    try:
        print(rss)
        feed = feedparser.parse(rss)

        print(feed)

        try:
            for entry in feed["entries"]:
                if (any(m in entry["published"] for m in valid_dates) and not entry["link"] in used_urls) and \
                        not any(bl in entry["link"].lower() for bl in filtered_urls) and \
                        not any(bl in entry["title"] for bl in filtered_words):
                    print()
                    print(entry["title"])
                    print(entry["link"].split("?cmp=rss")[0])
                    print(entry["published"])

        except Exception as e1:
            print("Exception", e1, "in RSS:", rss)
    except Exception as e2:
        print("Exception", e2, "Error with:", rss)