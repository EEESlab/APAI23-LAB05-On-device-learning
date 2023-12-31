APP = APAI_ODL

# User settings
NUM_CORES?=8
#APP_CFLAGS += -DDEBUG_LOSS
#APP_CFLAGS += -DOPTIMIZE     # Selects nth matmul to optimize execution
MATMUL_TYPE_FW_L0?=0         # Selects which optimized matmul to be used in FW (see mm_manager_list.txt or "MM_manager()" body to verify which one is called)
MATMUL_TYPE_WG_L0?=0         # Selects which optimized matmul to be used in WEIGHT GRAD (see mm_manager_list.txt or "MM_manager()" body to verify which one is called)
MATMUL_TYPE_IG_L0?=0         # Selects which optimized matmul to be used in IN GRAD (see mm_manager_list.txt or "MM_manager()" body to verify which one is called)
MATMUL_TYPE_FW_L1?=0         # Selects which optimized matmul to be used in FW (see mm_manager_list.txt or "MM_manager()" body to verify which one is called)
MATMUL_TYPE_WG_L1?=0         # Selects which optimized matmul to be used in WEIGHT GRAD (see mm_manager_list.txt or "MM_manager()" body to verify which one is called)
MATMUL_TYPE_IG_L1?=0         # Selects which optimized matmul to be used in IN GRAD (see mm_manager_list.txt or "MM_manager()" body to verify which one is called)
MATMUL_TYPE_FW_L2?=0         # Selects which optimized matmul to be used in FW (see mm_manager_list.txt or "MM_manager()" body to verify which one is called)
MATMUL_TYPE_WG_L2?=0         # Selects which optimized matmul to be used in WEIGHT GRAD (see mm_manager_list.txt or "MM_manager()" body to verify which one is called)
MATMUL_TYPE_IG_L2?=0         # Selects which optimized matmul to be used in IN GRAD (see mm_manager_list.txt or "MM_manager()" body to verify which one is called)
# End of user settings

NUM_MATMULS?=24		# Available standard matmuls in the library
TRAIN_LIB=./lib
TRAIN_LIB_SRCS=$(TRAIN_LIB)/sources
APP_SRCS = main.c net.c

APP_CFLAGS += -I. -I$(TRAIN_LIB)/include
APP_CFLAGS += -O3 -g3
APP_CFLAGS += -DFABRIC
APP_CFLAGS += -DCLUSTER
APP_CFLAGS += -DNUM_CORES=$(NUM_CORES)
APP_CFLAGS += -DPROF_NET
APP_CFLAGS += -DMATMUL_TYPE_FW_L0=${MATMUL_TYPE_FW_L0}
APP_CFLAGS += -DMATMUL_TYPE_WG_L0=${MATMUL_TYPE_WG_L0}
APP_CFLAGS += -DMATMUL_TYPE_IG_L0=${MATMUL_TYPE_IG_L0}
APP_CFLAGS += -DMATMUL_TYPE_FW_L1=${MATMUL_TYPE_FW_L1}
APP_CFLAGS += -DMATMUL_TYPE_WG_L1=${MATMUL_TYPE_WG_L1}
APP_CFLAGS += -DMATMUL_TYPE_IG_L1=${MATMUL_TYPE_IG_L1}
APP_CFLAGS += -DMATMUL_TYPE_FW_L2=${MATMUL_TYPE_FW_L2}
APP_CFLAGS += -DMATMUL_TYPE_WG_L2=${MATMUL_TYPE_WG_L2}
APP_CFLAGS += -DMATMUL_TYPE_IG_L2=${MATMUL_TYPE_IG_L2}
APP_LDFLAGS += -lm

# STATISTICS
APP_CFLAGS += -DSTATS

# SOURCES
APP_SRCS += $(TRAIN_LIB_SRCS)/pulp_act_fp32.c
APP_SRCS += $(TRAIN_LIB_SRCS)/pulp_conv_dw_fp32.c
APP_SRCS += $(TRAIN_LIB_SRCS)/pulp_conv_pw_fp32.c
APP_SRCS += $(TRAIN_LIB_SRCS)/pulp_conv2d_fp32.c
APP_SRCS += $(TRAIN_LIB_SRCS)/pulp_im2col_fp32.c
APP_SRCS += $(TRAIN_LIB_SRCS)/pulp_linear_fp32.c
APP_SRCS += $(TRAIN_LIB_SRCS)/pulp_losses_fp32.c
APP_SRCS += $(TRAIN_LIB_SRCS)/pulp_matmul_fp32.c
APP_SRCS += $(TRAIN_LIB_SRCS)/pulp_optimizers_fp32.c
APP_SRCS += $(TRAIN_LIB_SRCS)/pulp_pooling_fp32.c
APP_SRCS += $(TRAIN_LIB_SRCS)/pulp_train_utils_fp32.c

# RULES
get_golden:
	python ./utils/GM.py

include $(RULES_DIR)/pmsis_rules.mk
