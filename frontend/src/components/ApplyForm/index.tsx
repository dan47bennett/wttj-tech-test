import { InputText } from "welcome-ui/InputText";
import { Button } from "welcome-ui/Button";
import { Field } from "welcome-ui/Field";
import { useForm } from "react-hook-form";
import { Hint } from "welcome-ui/Hint";

export type ApplyFormValues = {
  full_name: string;
  email: string;
  phone: string;
  last_known_job: string;
  salary_expectation: number | string;
};

export type ApplyFormProps = {
  onSubmit: (values: ApplyFormValues) => Promise<void> | void;
  serverError?: string | null;
  initialLoading?: boolean;
};

export const ApplyForm = ({
  onSubmit,
  serverError,
  initialLoading = false,
}: ApplyFormProps) => {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<ApplyFormValues>({
    mode: "onChange",
    defaultValues: {
      full_name: "",
      email: "",
      phone: "",
      last_known_job: "",
      salary_expectation: "",
    },
  });

  const submit = handleSubmit(async (values) => {
    await onSubmit(values);
  });

  return (
    <form data-testid="apply-form" onSubmit={submit} noValidate>
      <Field
        error={errors.full_name?.message}
        className="mb-md"
        label="Full name"
        required
      >
        <InputText
          {...register("full_name", { required: "Full name is required" })}
          aria-invalid={errors.full_name ? "true" : "false"}
        />
      </Field>

      <Field
        required
        error={errors.email?.message}
        className="mb-md"
        label="Email"
      >
        <InputText
          type="email"
          {...register("email", { required: "Email is required" })}
          aria-invalid={errors.email ? "true" : "false"}
        />
      </Field>

      <Field
        required
        error={errors.phone?.message}
        className="mb-md"
        label="Phone"
      >
        <InputText
          {...register("phone", { required: "Phone is required" })}
          aria-invalid={errors.phone ? "true" : "false"}
        />
      </Field>

      <Field
        error={errors.last_known_job?.message}
        className="mb-md"
        label="Last known job"
        required
      >
        <InputText
          {...register("last_known_job", {
            required: "Last known job is required",
          })}
          aria-invalid={errors.last_known_job ? "true" : "false"}
        />
      </Field>

      <Field
        error={errors.salary_expectation?.message}
        className="mb-md"
        label="Salary expectation"
        required
      >
        <InputText
          type="number"
          {...register("salary_expectation", {
            required: "Salary expectation is required",
          })}
          aria-invalid={errors.salary_expectation ? "true" : "false"}
        />
      </Field>

      {serverError && (
        <Hint variant="danger" className="mb-md">
          {serverError}
        </Hint>
      )}

      <Button type="submit" disabled={isSubmitting || initialLoading}>
        {initialLoading || isSubmitting ? "Applying..." : "Apply"}
      </Button>
    </form>
  );
};

export default ApplyForm;
