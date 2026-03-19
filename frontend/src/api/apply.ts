export type ApplyParams = {
  full_name: string;
  email: string;
  phone: string;
  last_known_job: string;
  salary_expectation: number;
  job_id?: number | string;
};

export const apply = async (
  jobId: number | string,
  params: ApplyParams,
): Promise<void> => {
  const res = await fetch(`/api/jobs/${jobId}/apply`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ apply: params }),
  });

  if (!res.ok) {
    throw new Error("Apply failed");
  }

  return;
};
