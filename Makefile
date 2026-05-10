SKILLS_DIR := $(HOME)/.claude/skills
SRC_DIR    := skills

SKILLS := $(patsubst $(SRC_DIR)/%,%,$(wildcard $(SRC_DIR)/*))

.PHONY: install clean list $(SKILLS)

list:
	@echo "可安装的 skills："
	@for skill in $(SKILLS); do \
		echo "  $$skill"; \
	done

install: $(SKILLS)
	@echo "所有 skills 已安装到 $(SKILLS_DIR)"

$(SKILLS):
	@echo "安装 $@ ..."
	@rm -rf $(SKILLS_DIR)/$@
	@cp -r $(SRC_DIR)/$@ $(SKILLS_DIR)/$@
	@echo "  ✓ $@"

clean:
	@for skill in $(SKILLS); do \
		rm -rf $(SKILLS_DIR)/$$skill; \
		echo "  ✓ 已删除 $$skill"; \
	done
	@echo "所有 skills 已从 $(SKILLS_DIR) 清理"
