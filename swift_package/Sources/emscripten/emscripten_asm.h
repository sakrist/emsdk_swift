#ifndef MY_ASSEMBLY_H
#define MY_ASSEMBLY_H

#ifdef __cplusplus
extern "C" {
#endif

// Stack initialization and limits
void emscripten_stack_init(void);
void emscripten_stack_set_limits(void* stack_base, void* stack_end);
void* emscripten_stack_get_free(void);
void* emscripten_stack_get_base(void);
void* emscripten_stack_get_end(void);

// Stack operations
void emscripten_stack_restore(void* stack_ptr);
void* emscripten_stack_alloc(int size);
void* emscripten_stack_get_current(void);

#ifdef __cplusplus
}
#endif

#endif // MY_ASSEMBLY_H