# Use the specified Jupyter PyTorch notebook image
FROM quay.io/jupyter/pytorch-notebook:cuda12-pytorch-2.4.1

# Copy the local LLaMA file into the container
COPY Llama_3_2_1b_+_Unsloth_2x_faster_finetuning.ipynb /home/jovyan/work/Llama_3_2_1b_+_Unsloth_2x_faster_finetuning.ipynb

# Set the working directory
WORKDIR /home/jovyan/work

# Expose Jupyter port
EXPOSE 8888

# Start Jupyter with authentication
# CMD ["sh", "-c", "JUPYTER_TOKEN=$JUPYTER_TOKEN start-notebook.sh"]
