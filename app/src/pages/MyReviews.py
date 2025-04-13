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

restaurant_id = 2345

if restaurant_id:
    url = f"http://api:4000/r/restaurant_owners/reviews/{restaurant_id}"
    response = requests.get(url)

    if response.status_code == 200:
       data = response.json()
       df = pd.DataFrame(data)
       st.dataframe(df)
    else:
        st.error(f"Request failed with status: {response.status_code}")
else:
    st.info("Please enter your restaurant ID in the sidebar.")


# add reviews 

for review in data:
    review_id = review["review_ids"]
    content = review["all_reviews"]

    st.markdown(f"### Review #{review_id}")
    st.write(f"**Customer Review:** {content}")

    reply_text = st.text_area("Your Reply:", key=f"reply_{review_id}")

    if st.button("Submit Reply", key=f"submit_{review_id}"):
        st.success("Reply submitted!")
        print(f"Reply to review {review_id}: {reply_text}")  # or send to a log/email/etc
