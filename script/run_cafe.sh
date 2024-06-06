#!/bin/bash

root_dir="/home/jet/datasets/cafe_capture/benchmark_v6/"
#list="drpepper_v6"
#list="bunny_v6"
#list="book_v6"
list="sack_v6 teddy_v6"
#list="teddy_v6"
#list="3mbox_v6"

for i in $list; do
python train.py --eval \
-s ${root_dir}${i} \
-m output/cafe_capture/${i}/3dgs \
--lambda_normal_render_depth 0.01 \
--lambda_mask_entropy 0.1 \
--densification_interval 500 \
--iterations 20000 \
--checkpoint_interval 10000 \
--save_training_vis

python train.py --eval \
-s ${root_dir}${i} \
-m output/cafe_capture/${i}/neilf \
-c output/cafe_capture/${i}/3dgs/chkpnt20000.pth \
-t neilf \
--lambda_normal_render_depth 0.01 \
--use_global_shs \
--finetune_visibility \
--iterations 30000 \
--test_interval 1000 \
--checkpoint_interval 2500 \
--lambda_mask_entropy 0.1 \
--lambda_light 0.01 \
--lambda_base_color 0.005 \
--lambda_base_color_smooth 0.03 \
--lambda_metallic_smooth 0.01 \
--lambda_roughness_smooth 0.01 \
--lambda_visibility 0.1 \
--save_training_vis
done