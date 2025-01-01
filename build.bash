All custom features successfully injected into the build!
Step 6: Selecting the target device configuration...
Failed to compile android/soong/cmd/soong_ui: "/home/runner/work/WTRP/WTRP/prebuilts/go/linux-x86/pkg/tool/linux_amd64/compile -o /home/runner/work/WTRP/WTRP/out/.soong_ui_intermediates/android-soong-ui-tracer/android/soong/ui/tracer.a -p android/soong/ui/tracer -complete -pack -nolocalimports -c 4 -trimpath /home/runner/work/WTRP/WTRP -I /home/runner/work/WTRP/WTRP/out/.soong_ui_intermediates/android-soong-ui-logger -I /home/runner/work/WTRP/WTRP/out/.soong_ui_intermediates/android-soong-ui-status /home/runner/work/WTRP/WTRP/build/soong/ui/tracer/microfactory.go /home/runner/work/WTRP/WTRP/build/soong/ui/tracer/ninja.go /home/runner/work/WTRP/WTRP/build/soong/ui/tracer/status.go /home/runner/work/WTRP/WTRP/build/soong/ui/tracer/tracer.go": exit status 2
exit status 1
Step 7: Building the recovery image...
/home/runner/work/WTRP/WTRP/build/soong/ui/tracer/ninja.go:26:6: eventEntry redeclared in this block
	previous declaration at /home/runner/work/WTRP/WTRP/build/soong/ui/tracer/microfactory.go:25:6
/home/runner/work/WTRP/WTRP/build/soong/ui/tracer/ninja.go:32:6: method redeclared: tracerImpl.importEvents
	method(*tracerImpl) func([]*eventEntry)
	method(*tracerImpl) func([]*eventEntry)
/home/runner/work/WTRP/WTRP/build/soong/ui/tracer/ninja.go:32:22: (*tracerImpl).importEvents redeclared in this block
	previous declaration at /home/runner/work/WTRP/WTRP/build/soong/ui/tracer/microfactory.go:31:6
/home/runner/work/WTRP/WTRP/build/soong/ui/tracer/ninja.go:33:22: (*tracerImpl).importEvents.func1 redeclared in this block
	previous declaration at /home/runner/work/WTRP/WTRP/build/soong/ui/tracer/microfactory.go:32:22
/home/runner/work/WTRP/WTRP/build/soong/ui/tracer/ninja.go:130:16: cannot use entries (type []*eventEntry) as type []*eventEntry in argument to t.importEvents
Failed to compile android/soong/cmd/soong_ui: "/home/runner/work/WTRP/WTRP/prebuilts/go/linux-x86/pkg/tool/linux_amd64/compile -o /home/runner/work/WTRP/WTRP/out/.soong_ui_intermediates/android-soong-ui-tracer/android/soong/ui/tracer.a -p android/soong/ui/tracer -complete -pack -nolocalimports -c 4 -trimpath /home/runner/work/WTRP/WTRP -I /home/runner/work/WTRP/WTRP/out/.soong_ui_intermediates/android-soong-ui-logger -I /home/runner/work/WTRP/WTRP/out/.soong_ui_intermediates/android-soong-ui-status /home/runner/work/WTRP/WTRP/build/soong/ui/tracer/microfactory.go /home/runner/work/WTRP/WTRP/build/soong/ui/tracer/ninja.go /home/runner/work/WTRP/WTRP/build/soong/ui/tracer/status.go /home/runner/work/WTRP/WTRP/build/soong/ui/tracer/tracer.go": exit status 2
exit status 1
