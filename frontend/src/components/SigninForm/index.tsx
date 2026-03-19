import { InputText } from "welcome-ui/InputText";
import { PasswordInput } from "welcome-ui/PasswordInput";
import { Button } from "welcome-ui/Button";
import { Field } from "welcome-ui/Field";
import { Hint } from "welcome-ui/Hint";
import { useForm } from "react-hook-form";

export type SignInFormValues = { email: string; password: string };

export type SignInFormProps = {
  onSubmit: (values: SignInFormValues) => Promise<void> | void;
  serverError?: string | null;
  initialLoading?: boolean;
};

export const SignInForm = ({
  onSubmit,
  serverError,
  initialLoading = false,
}: SignInFormProps) => {
  const {
    register,
    handleSubmit,
    formState: { errors, isValid, isSubmitting },
  } = useForm<SignInFormValues>({
    mode: "onChange",
    defaultValues: { email: "", password: "" },
  });

  const submit = handleSubmit(async (values) => {
    await onSubmit(values);
  });

  return (
    <form data-testid="signin-form" onSubmit={submit} noValidate>
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
          {...register("password", { required: "Password is required" })}
          aria-invalid={errors.password ? "true" : "false"}
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
        {initialLoading || isSubmitting ? "Signing in..." : "Sign in"}
      </Button>
    </form>
  );
};
