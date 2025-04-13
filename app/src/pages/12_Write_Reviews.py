import logging

logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
from datetime import date

#Header
st.header("Leave a Review!")

# Inputs
user_id = st.text_input("User ID")
restaurant_id = st.text_input("Restaurant ID")

title = st.text_input("Review Title")
rating = st.text_area("Rating")
content = st.text_area("Review Content")
date_reported = st.date_input("Date", value=date.today())
review_id = st.text_input("Review ID")

#Submission of Reviews
if st.button("Submit Review"):
  data = {"title": title,"rating": rating,"content": content,"date_reported": str(date_reported),"review_id": review_id}

  endpoint = f"http://localhost:4000/reviews/{user_id}/{restaurant_id}"
  try:
        response = requests.put(f"http://api:4000/reviews/{user_id}/{restaurant_id}", json=data)
  except:
        st.write(f"Failed to update reviews/{user_id}/{restaurant_id}")
  if response.status_code == 200:
        st.write("Review Created!")