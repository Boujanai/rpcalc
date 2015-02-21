# -*- coding: utf-8 -*-


Plugin.create(:rpcalc) do


	command(
		:rpcalc,
		name: '逆ポーランド記法で計算',
		condition: lambda{ |opt| true },
		visible: true,
		role: :postbox
		) do |opt|


		array = Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text.split(' ')
		stack = []

		array.each do |n|
			if n == "+" then
				stack[1] = stack[1] + stack[0]
			elsif n == "-" then
				stack[1] = stack[1] - stack[0]
			elsif n == "*" then
				stack[1] = stack[1] * stack[0]
			elsif n == "/" then
				stack[1] = stack[1] / stack[0]
			else
				stack = [0, n.to_f] + stack
			end
			stack = stack[1..stack.size - 1]
		end
		if stack.size == 1
			Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text += " = " + stack[0].to_s
		else
			Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text += " Error"
		end

	end
end
