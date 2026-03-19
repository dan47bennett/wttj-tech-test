import { Link as WUILink } from "welcome-ui/Link";
import { Text } from "welcome-ui/Text";
import { Card } from "welcome-ui/Card";
import { Link } from "react-router-dom";
import { useSignIn } from "../components/SigninForm/useSignIn";
import { SignInFormValues, SignInForm } from "../components/SigninForm";

export const SignIn = () => {
  const { signIn, loading, error } = useSignIn();

  const onSubmit = async (values: SignInFormValues) => {
    await signIn(values);
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
            Sign in
          </Text>
          <SignInForm
            onSubmit={onSubmit}
            serverError={error}
            initialLoading={loading}
          />
        </Card.Body>
      </Card>
      <div className="text-center mt-md">
        <WUILink as={Link} to="/signup">
          Create an account
        </WUILink>
      </div>
    </div>
  );
};
