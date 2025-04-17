import logging
logger = logging.getLogger(__name__)
import streamlit as st
from streamlit_extras.app_logo import add_logo
import pandas as pd
import pydeck as pdk
from urllib.error import URLError
from modules.nav import SideBarLinks
import requests 

SideBarLinks()

# add the logo
add_logo("assets/logo.png", height=400)

# view all reviews 
st.header('My Reviews')

restaurant_id = 1
data = [] 

if restaurant_id:
    url = f"http://api:4000/r/restaurant_owners/all_ratings/{restaurant_id}"
    response = requests.get(url)  

    if response.status_code == 200:
        data = response.json()
    else:
        st.error(f"Request failed with status: {response.status_code}")
else:
    st.info("Please enter your restaurant ID in the sidebar.")

if data:
    for review in data:
        review_id = review["review_id"]
        content = review["content"]
        existing_reply = review.get("owner_reply", "")

        st.write(f"**Customer Review:** {content}")

        reply_text = st.text_area("Your Reply:", value=existing_reply, key=f"reply_{review_id}")

        if st.button("Submit Reply", key=f"submit_{review_id}"):
            reply_payload = {
                "review_ids": review_id,
                "owner_reply": reply_text
            }

            reply_response = requests.post("http://api:4000/r/restaurant_owners/reply", json=reply_payload)

            if reply_response.status_code == 200:
                st.success("Reply submitted!")

                review["owner_reply"] = reply_text

                st.text(f"Reply: {reply_text}")

            else:
                st.error(f"Failed to submit reply. Status code: {reply_response.status_code}")

        elif existing_reply:
            st.text(f"Reply: {existing_reply}")
