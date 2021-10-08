export const truncatePost = (post) => {
  if (post.length > 100) {
    return post.slice(0, 200) + "...";
  }
  return post;
};
