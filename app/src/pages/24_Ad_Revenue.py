import logging
logger = logging.getLogger(__name__)

import streamlit as st
import pandas as pd
import altair as alt
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('Ad Revenue')
st.write('### Summary')

adRevenue = requests.get('http://api:4000/a/adRevenue').json()

advertisements = requests.get('http://api:4000/a/advertisements').json()

advertisementsByAdvertiser = requests.get('http://api:4000/a/advertisementsByAdvertiser').json()

try:
    st.dataframe(adRevenue)
except:
    st.write("**Important**: Could not connect to database to get ad revenue!")

st.divider()
st.write('### Ad Revenue by Advertiser')
try:
    st.dataframe(advertisementsByAdvertiser)
    adsByAdvertiser = pd.DataFrame(advertisementsByAdvertiser)

    st.write('##### Chart of Ad Revenue by Advertiser')
    st.bar_chart(
    adsByAdvertiser,
    x="Advertiser ID",
    color=["#C8A2C8"],
    y="Ad Revenue by Advertiser",
    use_container_width=True,
    height=500,
    )
except:
    st.write("**Important**: Could not connect to database to get advertiser revenue data!")
    

st.divider()
st.write('### All Advertisements')
try:
    st.dataframe(advertisements)
    allAds = pd.DataFrame(advertisements)

    st.write('##### Chart of Ad Revenue by Ad')
    st.bar_chart(
    allAds,
    x="Ad ID",
    y="Ad Cost",
    color=["#E6E6FA"],
    use_container_width=True,
    height=400,
    )
except:
    st.write("**Important**: Could not connect to database to get ads!")
