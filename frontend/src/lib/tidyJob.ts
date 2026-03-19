import { CONTRACT_TYPE_OPTIONS } from '../consts';
import { Job } from '../types';

const tidyJob = (job: Job): Job => {
    const contractType = job.contract_type;

    const maybeOption = CONTRACT_TYPE_OPTIONS.find(
        (o) => o.value === contractType,
    );

    let contractTypeLabel = contractType;

    if (maybeOption) {
        contractTypeLabel = maybeOption.label;
    }

    return { ...job, contract_type: contractTypeLabel };
};

export default tidyJob;
