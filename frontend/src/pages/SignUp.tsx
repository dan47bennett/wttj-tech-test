import { Link as WUILink } from "welcome-ui/Link";
import { Text } from "welcome-ui/Text";
import { Card } from "welcome-ui/Card";
import { Link } from "react-router-dom";
import { SignUpForm, SignUpFormValues } from "../components/SignupForm";
import { useSignup } from "../components/SignupForm/useSignup";

export const SignUp = () => {
  const { signup, loading, error } = useSignup();

  const onSubmit = async (values: SignUpFormValues) => {
    await signup({ email: values.email, password: values.password });
  };

  return (
    <div className="max-w-640 mx-auto my-4xl p-xl">
      <WUILink
        as={Link}
        to="/"
        variant="secondary"
        className="mb-md inline-block"
      >
        ← Back to jobs
      </WUILink>
      <Card>
        <Card.Body>
          <Text variant="heading-xl" className="mb-lg">
            Create account
          </Text>
          <SignUpForm
            onSubmit={onSubmit}
            serverError={error}
            initialLoading={loading}
          />
        </Card.Body>
      </Card>
      <div className="text-center mt-md">
        <WUILink as={Link} to="/signin">
          Already have an account? Sign in
        </WUILink>
      </div>
    </div>
  );
};
