ifndef FOOTER_MK
FOOTER_MK = 1

ifeq ($(MODULE),)
MODULE := module-$(notdir $(CURDIR))
endif

vpath %.c $(SRC_DIR)
vpath %.cpp $(SRC_DIR)
SRC := $(foreach dir, $(SRC_DIR), $(wildcard $(dir)/*.c))
SRC += $(wildcard *.c)
SRC += $(foreach dir, $(SRC_DIR), $(wildcard $(dir)/*.cpp))
SRC += $(wildcard *.cpp)

OBJ_DIR := $(OBJS_DIR)/$(MODULE)

SRC_OBJ := $(SRC:.c=.o)
SRC_OBJ := $(SRC_OBJ:.cpp=.o)
OBJ := $(addprefix $(OBJ_DIR)/, $(notdir $(SRC_OBJ)))


plugin:$(PLUGIN_DIR)/lib$(MODULE).so

shared_library:$(LIBS_DIR)/lib$(MODULE).so

static_library:$(LIBS_DIR)/lib$(MODULE).a

executable:$(OUT_DIR)/$(MODULE)

custom:$(OBJ)

$(PLUGIN_DIR)/lib$(MODULE).so:$(OBJ) | $(PLUGIN_DIR)
	$(Q)echo "  PLUGIN  \033[1m\033[32mlib$(MODULE).so\033[0m"
	$(Q)$(CXX) -shared $(LDFLAGS) -o$@ $^ $(LIBS)

$(LIBS_DIR)/lib$(MODULE).so:$(OBJ) | $(LIBS_DIR)
	$(Q)echo "  LINK    \033[1m\033[32mlib$(MODULE).so\033[0m"
	$(Q)$(CXX) -shared $(LDFLAGS) -o$@ $^ $(LIBS)

$(LIBS_DIR)/lib$(MODULE).a:$(OBJ) | $(LIBS_DIR)
	$(Q)echo "  AR      \033[1m\033[32mlib$(MODULE).a\033[0m"
	$(Q)$(AR) -r $@ $^

$(OUT_DIR)/$(MODULE):$(OBJ)
	$(Q)echo "  BUILD   \033[1m\033[32m$(MODULE)\033[0m"
	$(Q)$(CXX) $(LDFLAGS) $(EXECUTABLE_LDFLAGS) -o$@ $^ $(LIBS) $(EXECUTABLE_LIBS)


-include $(OBJ:.o=.dep)

$(OBJ_DIR) $(LIBS_DIR) $(PLUGIN_DIR):
	$(Q)mkdir -p $@


$(OBJ_DIR)/%.o:%.c |$(OBJ_DIR)
	$(Q)echo "  CC      $<"
	$(Q)$(CC) $(CFLAGS) $(DEFINE) $(COMMON_INC) $(INCLUDE) -c $< -o $@ -MMD -MF $(@:.o=.dep)

$(OBJ_DIR)/%.o:%.cpp |$(OBJ_DIR)
	$(Q)echo "  CXX     $<"
	$(Q)$(CXX) $(CXXFLAGS) $(DEFINE) $(COMMON_INC) $(INCLUDE) -c $< -o $@ -MMD -MF $(@:.o=.dep)

$(eval $(cur-subdirs))
clean:custom-clean
	$(Q)for dir in $(subdirs);do \
		if [ -f $$dir/Makefile ];then \
		 $(MAKE) -C$$dir clean || exit "$$?"; \
		fi; \
	done;
	-rm -rf $(OBJ_DIR)
	$(Q)for type in $(build_type);do \
		case $$type in \
			executable) target=$(OUT_DIR)/$(MODULE) ;; \
			shared_library) target=$(LIBS_DIR)/lib$(MODULE).so ;; \
			plugin) target=$(PLUGIN_DIR)/lib$(MODULE).so ;; \
			static_library) target=$(LIBS_DIR)/lib$(MODULE).a ;; \
		esac; \
		if  [ -n "$$target" ];then \
			echo rm -rf $$target; \
			rm -rf $$target; \
		fi; \
	done


custom-clean:

install_plugin:
	-cp $(PLUGIN_DIR)/lib$(MODULE).so ~/.silentdream/plugins/ -rf


endif
