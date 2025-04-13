import logging

logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout="wide")

SideBarLinks()
advertiser_id = 1111
st.write("Your current ads")

advertisements = requests.get(
    f"http://api:4000/ad/ad_space/advertisement/{advertiser_id}"
)


# st.dataframe(, hide_index=True)

st.write(advertisements.text)


st.divider()


ad_id = st.text_input("Advertisement ID to edit:")
ad_content = st.text_area("Write new content:")


if st.button("Update Advertisement"):
    data = {
        "content": ad_content,
        "advertisement_id": ad_id,
    }

    try:
        response = requests.put(f"http://api:4000/ad/advertisement/{ad_id}", json=data)
    except:
        st.write(f"Failed to update advertisement/{ad_id}")

    if response.status_code == 200:
        st.write("Advertisement updated!")
