import { useCallback, useState } from "react";
import { useNavigate } from "react-router-dom";
import { LoginParams, login } from "../../api/login";
import Cookies from "js-cookie";

export const useSignIn = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const navigate = useNavigate();

  const signIn = useCallback(
    async (params: LoginParams) => {
      setError(null);
      setLoading(true);
      try {
        const token = await login(params);
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

  return { signIn, loading, error };
};
