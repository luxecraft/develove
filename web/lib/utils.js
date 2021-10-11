export const truncatePost = (post) => {
  if (post.length > 100) {
    return post.slice(0, 200) + "...";
  }
  return post;
};

export const getTimeOfDay = (hour) => {
  if (hour >= 5 && hour < 12) {
    return "Good Morning 🌥";
  } else if (hour >= 12 && hour < 17) {
    return "Good Afternoon 🌞";
  } else if (hour >= 17 && hour < 20) {
    return "Good Evening 🌇";
  } else {
    return "Good Night 🌘";
  }
};
