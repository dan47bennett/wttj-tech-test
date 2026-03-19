import { InputText } from "welcome-ui/InputText";
import { PasswordInput } from "welcome-ui/PasswordInput";
import { Button } from "welcome-ui/Button";
import { Field } from "welcome-ui/Field";
import { Hint } from "welcome-ui/Hint";
import { useForm } from "react-hook-form";

export type SignUpFormValues = {
  email: string;
  password: string;
  passwordConfirm: string;
};

export type SignUpFormProps = {
  onSubmit: (values: SignUpFormValues) => Promise<void> | void;
  serverError?: string | null;
  initialLoading?: boolean;
};

export const SignUpForm = ({
  onSubmit,
  serverError,
  initialLoading = false,
}: SignUpFormProps) => {
  const {
    register,
    handleSubmit,
    watch,
    formState: { errors, isValid, isSubmitting },
  } = useForm<SignUpFormValues>({
    mode: "onChange",
    defaultValues: { email: "", password: "", passwordConfirm: "" },
  });

  const password = watch("password");

  const submit = handleSubmit(async (values) => {
    await onSubmit(values);
  });

  return (
    <form data-testid="signup-form" onSubmit={submit} noValidate>
      <Field error={errors.email?.message} className="mb-md" label="Email">
        <InputText
          type="email"
          {...register("email", { required: "Email is required" })}
          aria-invalid={errors.email ? "true" : "false"}
        />
      </Field>

      <Field
        error={errors.password?.message}
        className="mb-md"
        label="Password"
      >
        <PasswordInput
          {...register("password", {
            required: "Password is required",
            minLength: {
              value: 12,
              message: "Password must be at least 12 characters",
            },
          })}
          aria-invalid={errors.password ? "true" : "false"}
        />
      </Field>

      <Field
        error={errors.passwordConfirm?.message}
        className="mb-md"
        label="Confirm password"
      >
        <PasswordInput
          {...register("passwordConfirm", {
            required: "Confirm password is required",
            validate: (v) => v === password || "Passwords do not match",
          })}
          aria-invalid={errors.passwordConfirm ? "true" : "false"}
        />
      </Field>

      {serverError && (
        <Hint variant="danger" className="mb-md">
          {serverError}
        </Hint>
      )}
      <Button
        type="submit"
        disabled={!isValid || isSubmitting || initialLoading}
      >
        {initialLoading || isSubmitting
          ? "Creating account..."
          : "Create account"}
      </Button>
    </form>
  );
};
