import { useCallback, useState } from "react";
import { useNavigate } from "react-router-dom";
import { RegisterParams, register } from "../../api/register";
import Cookies from "js-cookie";

export type SignupParams = RegisterParams;

export const useSignup = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const navigate = useNavigate();

  const signup = useCallback(
    async (params: SignupParams) => {
      setError(null);
      setLoading(true);
      try {
        const token = await register({
          email: params.email,
          password: params.password,
        });
        Cookies.set("user-token", token);
        navigate("/", { replace: true });
      } catch (err: any) {
        setError(err.message || "Unknown error");
        throw err;
      } finally {
        setLoading(false);
      }
    },
    [navigate],
  );

  return { signup, loading, error };
};
