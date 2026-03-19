import { useCallback, useState } from "react";
import { useNavigate } from "react-router-dom";
import { ApplyParams, apply } from "../../api/apply";

export const useApply = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const navigate = useNavigate();

  const handleApply = useCallback(
    async (jobId: number | string, params: ApplyParams) => {
      setError(null);
      setLoading(true);
      try {
        await apply(jobId, params);
        navigate("/", { replace: true });
      } catch (err: any) {
        setError("Unknown error");
        throw err;
      } finally {
        setLoading(false);
      }
    },
    [navigate],
  );

  return { handleApply, loading, error };
};
