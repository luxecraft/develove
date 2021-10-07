import React from "react";
import { useForm } from "react-hook-form";

function PostEdit() {
  const { register, handleSubmit, reset, watch, formState } = useForm({
    defaultValues,
    mode: "onChange",
  });

  const { isDirty, isValid, errors } = formState;

  return (
    <div>
      <form action="">
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

export default PostEdit;
