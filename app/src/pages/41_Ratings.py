import logging
logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from streamlit_extras.app_logo import add_logo
import world_bank_data as wb
import matplotlib.pyplot as plt
import numpy as np
import plotly.express as px
from modules.nav import SideBarLinks
import requests

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

restaurant_id = 1

st.header('Restaurant Statistics')

st.write(f"### Hi, {st.session_state['first_name']}! Your overall rating is:")

if restaurant_id:
    url = f"http://api:4000/r/restaurant_owners/{restaurant_id}"
    response = requests.get(url)

    if response.status_code == 200:
       data = response.json()[0]
       st.header(f"{data['average']} ⭐")
       #df = pd.DataFrame(data)
       #st.dataframe(df)
    else:
        st.error(f"Request failed with status: {response.status_code}")
else:
    st.info("Please enter your restaurant ID in the sidebar.")



url2 = f"http://api:4000/r/restaurant_owners/all_ratings/{restaurant_id}"
response2 = requests.get(url2)

if response2.status_code == 200:
    data2 = response2.json()
    df2 = pd.DataFrame(data2)
    st.dataframe(df2)
else:
    st.error(f"Request failed with status: {response.status_code}")
    
scores = []
for rating in data2:
    scores.append(int(rating["rating"]))

# title

# create the histogram
fig, ax = plt.subplots()
ax.hist(scores, bins=20, edgecolor='black')
ax.set_xlabel('Review Rating')
ax.set_ylabel('Frequency')

# Display in Streamlit
st.pyplot(fig)