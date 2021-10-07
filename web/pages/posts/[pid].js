import React from "react";
import { useForm } from "react-hook-form";

function PostDisplay() {
  const { register, handleSubmit, reset, watch, formState } = useForm({
    defaultValues,
    mode: "onChange",
  });

  const { isDirty, isValid, errors } = formState;

  const updatePost = async ({ content, published }) => {
    await reset({ content, published });

    toast.success("Post was updated successfully");
  };

  return (
    <div>
      <form onSubmit={handleSubmit(updatePost)}>
        <input type="text" name="title" ref={register({ required: true })} />
        <textarea
          name="content"
          {...register("content", {
            maxLength: { value: 2000, message: "content is too long" },
            minLength: { value: 10, message: "content is too small" },
            required: { value: true, message: "content is required" },
          })}
        ></textarea>
        {errors.content && (
          <p className="text-danger">{errors.content.message}</p>
        )}
        <button
          type="submit"
          className=" bg-primary-solid "
          disabled={!isValid || !isDirty}
        >
          Save Changes
        </button>
      </form>
    </div>
  );
}

export default PostDisplay;
